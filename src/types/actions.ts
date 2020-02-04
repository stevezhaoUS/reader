import { AnyAction } from "redux";

export enum enumActions {
  TOGGLE_SIDE_MENU = "TOGGLE_SIDE_MENU",
  TOGGLE_CONTROL_PANEL = "TOGGLE_CONTROL_PANEL",

  FETCH_SHELF_DATA = "FETCH_SHELF_DATA",

  FETCH_SHELF_DATA_SUCCESS = "FETCH_SHELF_DATA_SUCCESS"
}

export interface IAction extends AnyAction {
  data?: any;
  error?: any;
}
