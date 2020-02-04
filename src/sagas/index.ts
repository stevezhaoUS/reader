import { all } from "redux-saga/effects";
import { watchFetchShelf } from "./shelf";
export default function* root() {
  yield all([watchFetchShelf()]);
}
