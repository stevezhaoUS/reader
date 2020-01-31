import { enumActions, IAction } from '../types/actions';
export function actionToggleSideMenu(): IAction {
  return {
    type: enumActions.TOGGLE_SIDE_MENU
  };
}

export function actionToggleControlPanel(): IAction {
  return {
    type: enumActions.TOGGLE_CONTROL_PANEL
  };
}
