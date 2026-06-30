import { Routes } from '@angular/router';
import { ArtistComponent } from './artist/artist.component';
import { ArtistIndexComponent } from './artist/artist-index.component';
import { AlbumIndexComponent } from './album/album-index.component';
import { AlbumComponent } from './album/album.component';
import { DeeJayIndexComponent } from './dee-jay/dee-jay-index.component';
import { DeeJayComponent } from './dee-jay/dee-jay.component';
import { RadioShowIndexComponent } from './radio-show/radio-show-index.component';
import { RadioShowComponent } from './radio-show/radio-show.component';
import { SongIndexComponent } from './song/song-index.component';
import { SongComponent } from './song/song.component';

export const routes: Routes = [
    {
        path: 'artists',
        component: ArtistIndexComponent
    },
     {
        path: 'artists/:id',
        component: ArtistComponent
    },
    {
        path: 'albums',
        component: AlbumIndexComponent
    },
    {
        path: 'albums/:id',
        component: AlbumComponent
    },
    {
        path: 'deejays',
        component: DeeJayIndexComponent
    },
    {
        path: 'deejays/:id',
        component: DeeJayComponent
    }, 
    {
        path: 'radioshows',
        component: RadioShowIndexComponent
    },
    {
        path: 'radioshows/:id',
        component: RadioShowComponent
    }, 
    {
        path: 'songs',
        component: SongIndexComponent
    },
    {
        path: 'songs/:id',
        component: SongComponent
    }, 
];
