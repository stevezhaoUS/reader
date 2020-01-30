import { Reducer } from "redux"
import { enumActions, IAction } from '../types/actions';

const initialState = {
    showControlPanel: false
}
export default function (state = initialState, action: IAction) {
    switch (action.type) {
        case enumActions.TOGGLE_CONTROL_PANEL:
            return { ...state, showControlPanel: !state.showControlPanel}
        default:
            return state;
    }
}