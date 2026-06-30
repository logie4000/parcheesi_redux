import { httpResource } from '@angular/common/http';
import { Component, computed, signal } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ModelService } from '../services/model.service';

@Component({
    selector: 'app-model',
    imports: [],
    template: '',
    styleUrls: []
})
export abstract class ModelComponent<Model> {
    id = signal<number>(0);
    endpointUrl: string = '';
  
    params$ = this.activatedRoute.params.subscribe( (params) => {
      var id = parseInt(params['id']);
      if (!Number.isNaN(id)) {
        this.id.set(id);
      }
    })
  
    loadResource = httpResource<Model>( () => {
      if (this.id() == 0) {
        return undefined;
      }
  
      return `${this.modelService.endpointUrl}/${this.id()}`
    });
  
    constructor(protected activatedRoute: ActivatedRoute, protected modelService: ModelService<Model>) {
  
    }
  
    isLoading = computed(() => this.loadResource.isLoading());
    error = computed(() => this.loadResource.error());
    model = this.loadResource.value;
  }
  