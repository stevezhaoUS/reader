import { enumActions } from "../types/actions";
export function fetchShelf() {
  return {
    type: enumActions.FETCH_SHELF_DATA
  };
}
