import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";

@Injectable({
    providedIn: 'root'
})
export abstract class ModelService<Model> {
    abstract endpointUrl: string;
    abstract api: string;
    abstract itemUrl(item: Model): string;

    constructor(protected http: HttpClient) {

    }

    fetchData(id: number): Observable<Model> {
        const url = `/${this.endpointUrl}/${id}`

        var payload =  this.http.get<Model>(url);

        return payload;
    }
}