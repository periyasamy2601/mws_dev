"use strict";
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AvkApiApplication = void 0;
const tslib_1 = require("tslib");
const path_1 = tslib_1.__importDefault(require("path"));
require('dotenv').config({
    path: path_1.default.join(__dirname, `../env/.env.${(_a = process.env.NODE_ENV) !== null && _a !== void 0 ? _a : 'development'}`),
});
const boot_1 = require("@loopback/boot");
const repository_1 = require("@loopback/repository");
const rest_1 = require("@loopback/rest");
const rest_explorer_1 = require("@loopback/rest-explorer");
const service_proxy_1 = require("@loopback/service-proxy");
const datasources_1 = require("./datasources");
const sequence_1 = require("./sequence");
class AvkApiApplication extends (0, boot_1.BootMixin)((0, service_proxy_1.ServiceMixin)((0, repository_1.RepositoryMixin)(rest_1.RestApplication))) {
    constructor(options = {}) {
        super(options);
        // Set up the custom binding
        this.setupBinding();
        // Set up the custom sequence
        this.sequence(sequence_1.MySequence);
        // Set up default home page
        this.static('/', path_1.default.join(__dirname, '../public'));
        // Customize @loopback/rest-explorer configuration here
        this.configure(rest_explorer_1.RestExplorerBindings.COMPONENT).to({
            path: '/explorer',
        });
        this.component(rest_explorer_1.RestExplorerComponent);
        this.projectRoot = __dirname;
        // Customize @loopback/boot Booter Conventions here
        this.bootOptions = {
            controllers: {
                // Customize ControllerBooter Conventions here
                dirs: ['controllers'],
                extensions: ['.controller.js'],
                nested: true,
            },
        };
    }
    setupBinding() {
        this.bind('datasources.AvkDataSource').toClass(datasources_1.AvkDataSource);
    }
}
exports.AvkApiApplication = AvkApiApplication;
//# sourceMappingURL=application.js.map