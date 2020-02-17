import React, { Component, useState } from "react";
import { View, Text, SafeAreaView, StatusBar, StyleSheet, ScrollView, RefreshControl} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import Constants from 'expo-constants';
import { Button } from 'react-native-elements';
import { BookList } from "./shelf/BookList";

export default function Shelf() {
  const [refreshing, setRefreshing] = useState(false);
  const onRefresh = React.useCallback(() => {
    setRefreshing(true);
    wait(2000).then(() => {
      setRefreshing(false);
    })
  }, [refreshing])

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.navbar}>
        <Text style={styles.navBarTitle}>Shelf</Text>
        <View style={styles.navBarIcons}>
          <Button
            type="clear"
            icon={ <Icon size={20} style={styles.searchBtn} name="search" color="white" /> }
          />
          <Button 
            type="clear"
            icon={ <Icon size={20} name="ellipsis-v" color="white" /> } />
        </View>
      </View>
      <ScrollView 
        contentContainerStyle={styles.scrollView}
        refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }>
      <View style={styles.bannerView}>
          <Text>View1</Text>
      </View>
      <View style={styles.bookList}>
          <BookList />
      </View>
      </ScrollView>
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  container: {
    marginTop: Constants.statusBarHeight,
    flex: 1,
    flexDirection: 'column'
  },
  navbar: {
    paddingHorizontal: 15,
    flexDirection: 'row',
    height: 40,
    backgroundColor: '#535c65',
    alignItems: 'center',
    justifyContent: "space-between"
  },
  navBarTitle: {
    fontSize: 18,
    fontWeight: "400",
    color: 'white',
  },
  navBarIcons: {
    flexDirection: 'row',
    alignItems: "center"

  },
  searchBtn: {
    fontSize: 20,
  },
  scrollView: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: 'white'
  },
  bannerView: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: '#535c65',
    width: '100%'
  },
  bookList: {
    flex: 3
  }
});


function wait(timeout) {
  return new Promise(resolve => {
    setTimeout(resolve, timeout);
  });
}
