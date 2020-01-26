import { AnyAction } from 'redux';

export enum enumActions {
    TOGGLE_SIDE_MENU = 'TOGGLE_SIDE_MENU'
}

export interface IAction extends AnyAction {
    payload?: any
}

