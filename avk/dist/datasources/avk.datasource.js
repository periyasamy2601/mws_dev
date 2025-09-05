"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AvkDataSource = void 0;
const tslib_1 = require("tslib");
const core_1 = require("@loopback/core");
const repository_1 = require("@loopback/repository");
const config = {
    name: 'avk',
    connector: 'postgresql',
    url: 'postgresql://' +
        process.env.DB_USER +
        ':' +
        process.env.DB_PASSWORD +
        '@' +
        process.env.DB_HOST +
        '/' +
        process.env.DB_NAME +
        '?retryWrites=true&w=majority',
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
};
// Observe application's life cycle to disconnect the datasource when
// application is stopped. This allows the application to be shut down
// gracefully. The `stop()` method is inherited from `juggler.DataSource`.
// Learn more at https://loopback.io/doc/en/lb4/Life-cycle.html
let AvkDataSource = class AvkDataSource extends repository_1.juggler.DataSource {
    constructor(dsConfig = config) {
        var _a;
        super(dsConfig);
        this.retryDelay = Number((_a = process.env.DB_RETRY) !== null && _a !== void 0 ? _a : 15000);
        // Listen for the 'connected' event and log a success message
        this.on('connected', () => {
            console.log(`✅ Connected to ${process.env.DB_NAME} database successfully!`);
        });
        // Listen for the 'error' event and log an error message
        this.on('error', async (err) => {
            console.error({
                message: `❌ ${process.env.DB_NAME} database connection failed: ${err.message}`,
            });
            setTimeout(() => this.reconnect(), this.retryDelay);
        });
    }
    /**
    * Establish connection while connection was closed
    */
    async reconnect() {
        try {
            await this.connect();
            await this.verifyConnection();
            console.log(`✅ Successfully reconnected to ${process.env.DB_NAME} database.`);
        }
        catch (err) {
            console.error({
                message: `❌ Failed to reconnect to ${process.env.DB_NAME} database:`,
                err,
            });
        }
    }
    // To verify the database connection
    async verifyConnection() {
        try {
            await this.execute('SELECT 1');
            console.log(`✅ ${process.env.DB_NAME} Database connection verified successfully`);
        }
        catch (error) {
            console.error({
                message: `❌ Failed to verify ${process.env.DB_NAME} database connection:`,
                error,
            });
            throw error;
        }
    }
    /**
   * Disconnect the datasource when application is stopped. This allows the
   * application to be shut down gracefully.
   */
    stop() {
        return super.disconnect();
    }
};
exports.AvkDataSource = AvkDataSource;
AvkDataSource.dataSourceName = 'avk';
AvkDataSource.defaultConfig = config;
exports.AvkDataSource = AvkDataSource = tslib_1.__decorate([
    (0, core_1.lifeCycleObserver)('datasource'),
    tslib_1.__param(0, (0, core_1.inject)('datasources.config.avk', { optional: true })),
    tslib_1.__metadata("design:paramtypes", [Object])
], AvkDataSource);
//# sourceMappingURL=avk.datasource.js.map