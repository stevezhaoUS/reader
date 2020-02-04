import { enumActions, IAction } from "../types/actions";

const initialState = {
  showSideMenu: false,
  books: []
};
export type ShelfStates = typeof initialState;

export default function(state = initialState, action: IAction) {
  switch (action.type) {
    case enumActions.TOGGLE_SIDE_MENU:
      return { ...state, showSideMenu: !state.showSideMenu };
    case enumActions.FETCH_SHELF_DATA_SUCCESS:
      return { ...state, books: action.data.books };
    default:
      return state;
  }
}
