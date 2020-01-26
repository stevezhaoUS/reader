import { Reducer } from "redux"
import { enumActions, IAction } from '../types/actions';

export const SideMenu: Reducer = (state = { open: false }, action: IAction) => {
    switch(action.type) {
        case enumActions.TOGGLE_SIDE_MENU:
            return { ...state, open: !state.open }
        default:
            return state;
    }
}