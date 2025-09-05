import { LifeCycleObserver, ValueOrPromise } from '@loopback/core';
import { juggler } from '@loopback/repository';
export declare class AvkDataSource extends juggler.DataSource implements LifeCycleObserver {
    static dataSourceName: string;
    static readonly defaultConfig: {
        name: string;
        connector: string;
        url: string;
        host: string;
        port: string;
        user: string;
        password: string;
        database: string;
    };
    private readonly retryDelay;
    constructor(dsConfig?: object);
    /**
    * Establish connection while connection was closed
    */
    reconnect(): Promise<void>;
    private verifyConnection;
    /**
   * Disconnect the datasource when application is stopped. This allows the
   * application to be shut down gracefully.
   */
    stop(): ValueOrPromise<void>;
}
