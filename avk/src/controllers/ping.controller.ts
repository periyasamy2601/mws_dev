import {inject} from '@loopback/core';
import {
  get,
  param,
  Request,
  Response,
  response,
  ResponseObject,
  RestBindings,
} from '@loopback/rest';
import {AvkDataSource} from '../datasources';

export interface IDatabaseConnectionState {
  result: number;
}

/**
 * OpenAPI response for ping()
 */
const PING_RESPONSE: ResponseObject = {
  description: 'Ping Response',
  content: {
    'application/json': {
      schema: {
        type: 'object',
        title: 'PingResponse',
        properties: {
          greeting: {type: 'string'},
          date: {type: 'string'},
          url: {type: 'string'},
          headers: {
            type: 'object',
            properties: {
              'Content-Type': {type: 'string'},
            },
            additionalProperties: true,
          },
        },
      },
    },
  },
};

/**
 * A simple controller to bounce back http requests
 */
export class PingController {
  constructor(
    @inject(RestBindings.Http.REQUEST) private req: Request,
    @inject('datasources.AvkDataSource')
    private readonly apiDataSource: AvkDataSource,
    @inject(RestBindings.Http.RESPONSE) private readonly res: Response,

  ) { }

  // Map to `GET /ping`
  @get('/ping')
  @response(200, {
    description: 'Ping',
    content: {
      'application/json': {
        schema: {
          type: 'object',
          properties: {
            message: {
              type: 'string',
              default: 'Success',
            },
          },
        },
      },
    },
  })
  async ping() {
    return {message: 'Success'};
  }

  // Map to `GET /ping`
  @get('/health')
  @response(200, {
    description: 'Ping',
    content: {
      'text/html': {
        schema: {type: 'string'},
      },
    },
  })
  async pingStatus(
    @param.query.number('type') type: number,
  ) {
    try {
      type = type ?? 0;
      let isDatabaseConnected = false;
      let isRedisConnected = false;
      let isMqttConnected = false;

      // Check Database Connection
      try {
        // Attempt to ping the database; cast result as needed
        const DB_STATE =
          (await this.apiDataSource.ping()) as unknown as IDatabaseConnectionState[];
        isDatabaseConnected = !!DB_STATE;
        console.log(`Database Connected: ${isDatabaseConnected}`);
      } catch (error) {
        isDatabaseConnected = false;
        console.error(error, 'Database Connection Failed');
      }

      // Function to return an HTML circle dot indicating status
      const statusDot = (status: boolean) =>
        `<span style="display:inline-block;width:10px;height:10px;border-radius:50%;background-color:${status ? 'green' : 'red'
        };margin-right:8px;"></span>`;
      // Build Body Content Section
      const BODY_CONTENT = `<h1>Avk API Status</h1>
    <div class="section">
      <h2>Core Services</h2>
      <ul>
        <li>${statusDot(isDatabaseConnected)} Database</li>
      </ul>
    </div>`;
      // Create the main status content block for the service health report
      const HTML_CONTENT = `
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Avk API Status</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background: #f9f9f9;
        padding: 20px;
      }
      .section {
        margin-bottom: 30px;
        border-left: 4px solid #007bff;
        padding-left: 12px;
      }
      .section h2 {
        text-transform: uppercase;
        font-size: 16px;
        margin-bottom: 10px;
      }
      ul {
        list-style-type: none;
        padding-left: 0;
      }
      li {
        margin: 5px 0;
      }
    </style>
  </head>
  <body>
    ${BODY_CONTENT}
  </body>
  </html>
  `;
      let RESPONSE = type ? BODY_CONTENT : HTML_CONTENT;
      this.res.contentType('text/html');
      // To get API status code
      const STATUS_CODE = this.getConnectionStatusCode([
        {status: isDatabaseConnected, errorCode: 531},
        {status: isRedisConnected, errorCode: 532},
        {status: isMqttConnected, errorCode: 533},
      ]);

      this.res.status(STATUS_CODE).send(RESPONSE);
      return this.res;
    } catch (error) {
      throw error;
    }
  }

  /**
   * Returns status code based on connection booleans
   * @param connections Array of objects with `status` and `errorCode`
   * @returns number HTTP status code
   */
  getConnectionStatusCode(
    connections: {status: boolean; errorCode: number}[],
  ): number {
    for (const conn of connections) {
      if (!conn.status) {
        return conn.errorCode;
      }
    }
    return 200; // All connections successful
  }
}
