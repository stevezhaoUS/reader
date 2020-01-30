import { AnyAction } from 'redux';

export enum enumActions {
    TOGGLE_SIDE_MENU = 'TOGGLE_SIDE_MENU',
    TOGGLE_CONTROL_PANEL = "TOGGLE_CONTROL_PANEL"
}

export interface IAction extends AnyAction {
    payload?: any
}

