import {
  GridList,
  GridListTile,
  GridListTileBar,
  IconButton
} from "@material-ui/core";
import { MoreHoriz } from "@material-ui/icons";
import React, { useEffect } from "react";
import { connect, DispatchProp } from "react-redux";
import { actionToggleSideMenu } from "../../actions/Menus";
import { AppState } from "../../reducers";
import { ShelfStates } from "../../reducers/Shelf.reducer.";
import { IAction } from "../../types/actions";
import NavBar from "../navbar/Navbar";
import { SideMenu } from "../sideMenu/SideMenu";
import styles from "./Shelf.jss";
import { actionFetchShelfData } from "../../actions/shelfAction";

const mapStateToProps = (state: AppState) => ({
  showSideMenu: state.Shelf.showSideMenu,
  books: state.Shelf.books
});

type PropsType = ShelfStates & DispatchProp<IAction>;

const Shelf: React.FC<PropsType> = (props: PropsType) => {
  const classes = styles();
  const { dispatch, books } = props;

  const toggleSideMenu = () => {
    dispatch(actionToggleSideMenu());
  };

  useEffect(() => {
    console.log("useEffect in shelf");
    dispatch(actionFetchShelfData());
  });

  return (
    <div className={classes.root}>
      <NavBar />
      <GridList
        cols={3}
        cellHeight={180}
        spacing={16}
        className={classes.gridList}
      >
        {books.map(v => (
          <GridListTile key={v}>
            <img src="no_img.png" alt="" />
            <GridListTileBar
              title="title"
              subtitle="subtitle"
              actionIcon={
                <IconButton className={classes.icon}>
                  <MoreHoriz />
                </IconButton>
              }
            />
          </GridListTile>
        ))}
      </GridList>
      <SideMenu open={props.showSideMenu} onClose={toggleSideMenu} />
    </div>
  );
};

export default connect(mapStateToProps)(Shelf);
