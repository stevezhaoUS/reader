import {
  GridList,
  GridListTile,
  GridListTileBar,
  IconButton
} from "@material-ui/core";
import { MoreHoriz } from "@material-ui/icons";
import React from "react";
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
  const { dispatch, books } = props;

  const toggleSideMenu = () => {
    dispatch(actions.actionToggleSideMenu());
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
          <GridListTile key={i}>
            <img src={book.meta.cover || "no_img.png"} alt="" />
            <GridListTileBar
              title={book.meta.title}
              subtitle={book.summary}
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
