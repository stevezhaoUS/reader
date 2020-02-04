import { enumActions } from "../types/actions";
export function actionFetchShelfData() {
  return {
    type: enumActions.FETCH_SHELF_DATA
  };
}
