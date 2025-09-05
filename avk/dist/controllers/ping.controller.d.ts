/// <reference types="express" />
import { Request, Response } from '@loopback/rest';
import { AvkDataSource } from '../datasources';
export interface IDatabaseConnectionState {
    result: number;
}
/**
 * A simple controller to bounce back http requests
 */
export declare class PingController {
    private req;
    private readonly apiDataSource;
    private readonly res;
    constructor(req: Request, apiDataSource: AvkDataSource, res: Response);
    ping(): Promise<{
        message: string;
    }>;
    pingStatus(type: number): Promise<Response<any, Record<string, any>>>;
    /**
     * Returns status code based on connection booleans
     * @param connections Array of objects with `status` and `errorCode`
     * @returns number HTTP status code
     */
    getConnectionStatusCode(connections: {
        status: boolean;
        errorCode: number;
    }[]): number;
}
