import { takeEvery, call, put } from "redux-saga/effects";
import { enumActions } from "../types/actions";
import Axios from "axios";

export function* watchFetchShelf() {
  yield takeEvery(enumActions.FETCH_SHELF_DATA, fetchShelfData);
}

function* fetchShelfData() {
  try {
    const payload = yield call(Axios.get, "/shelf");
    yield put({
      type: enumActions.FETCH_SHELF_DATA_SUCCESS,
      data: payload.data
    });
  } catch (error) {
    yield put({ type: "FETCH_FAILED", error });
    console.error("product api load failed");
  }
}
