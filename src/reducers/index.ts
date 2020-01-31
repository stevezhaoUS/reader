import { combineReducers } from 'redux';
import Shelf from './Shelf.reducer.';
import Reader from './Reader.reducer';

export const rootReducer = combineReducers({
  Shelf,
  Reader
});

export type AppState = ReturnType<typeof rootReducer>;
