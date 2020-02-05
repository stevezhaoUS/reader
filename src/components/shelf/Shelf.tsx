import {
  GridList,
  GridListTile,
  GridListTileBar,
  IconButton,
  Menu,
  MenuItem
} from "@material-ui/core";
import { MoreHoriz } from "@material-ui/icons";
import React, { useState } from "react";
import { connect, DispatchProp } from "react-redux";
import * as actions from "../../actions";
import { AppState } from "../../reducers";
import { ShelfStates } from "../../reducers/Shelf.reducer.";
import { IAction } from "../../types/actions";
import NavBar from "../navbar/Navbar";
import { SideMenu } from "../sideMenu/SideMenu";
import styles from "./Shelf.jss";
import { Book } from "../../types/books";

const mapStateToProps = (state: AppState) => ({
  showSideMenu: state.Shelf.showSideMenu,
  books: state.Shelf.books
});

type PropsType = ShelfStates & DispatchProp<IAction>;

const Shelf: React.FC<PropsType> = (props: PropsType) => {
  const classes = styles();
  const [anchorEl, setAnchorEl] = React.useState<HTMLElement | null>(null);
  const { dispatch, books } = props;

  const toggleSideMenu = () => {
    dispatch(actions.actionToggleSideMenu());
  };

  const actionMenuClick = (event: React.MouseEvent<HTMLElement>) => {
    event.stopPropagation();
    setAnchorEl(event.currentTarget);
  };

  const actionMenuClose = (event: React.MouseEvent<HTMLElement>) => {
    event.stopPropagation();
    setAnchorEl(null);
  };

  return (
    <div className={classes.root}>
      <NavBar />
      <GridList
        cols={3}
        cellHeight={240}
        spacing={16}
        className={classes.gridList}
      >
        {books.map((book: Book, i) => (
          <GridListTile key={i} onClick={() => alert("ok")}>
            <img src={book.meta.cover || "no_img.png"} alt="" />
            <GridListTileBar
              title={book.meta.title}
              subtitle={book.summary}
              actionIcon={
                <IconButton onClick={actionMenuClick} className={classes.icon}>
                  <MoreHoriz />
                </IconButton>
              }
            />
            <Menu
              id="actionMenu"
              anchorEl={anchorEl}
              keepMounted
              open={Boolean(anchorEl)}
              onClose={actionMenuClose}
            >
              <MenuItem onClick={actionMenuClose}>Delete</MenuItem>
              <MenuItem onClick={actionMenuClose}>Rename</MenuItem>
            </Menu>
          </GridListTile>
        ))}
      </GridList>
      <SideMenu open={props.showSideMenu} onClose={toggleSideMenu} />
    </div>
  );
};

export default connect(mapStateToProps)(Shelf);
