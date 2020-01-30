import { enumActions, IAction } from '../types/actions';

const initialState = {
    showSideMenu: false,
}
export type ShelfStates = typeof initialState;

export default function (state = initialState, action: IAction) {
    switch (action.type) {
        case enumActions.TOGGLE_SIDE_MENU:
            return { ...state, showSideMenu: !state.showSideMenu }
        default:
            return state;
    }
}