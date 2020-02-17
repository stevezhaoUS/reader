import React from 'react';
import { Text, View, Image, StyleSheet, FlatList, TouchableOpacity, ListRenderItemInfo } from 'react-native';
import { ScrollView } from 'react-native-gesture-handler';

const listData = [
    {
        uuid: 'song-of-ice-and-fire',
        title: 'game of thron',
        author: 'luther',
        cover: '',
        catalog: 'magic',
        summary: 'the story is about dragon and magic'
    },
    {
        uuid: 'song-of-ice-and-fire2',
        title: 'King of north',
        author: 'luther',
        cover: '',
        catalog: 'magic',
        summary: 'the story is about dragon and magic'
    },
    {
        uuid: 'song-of-ice-and-fire3',
        title: 'Bloody marriage',
        author: 'luther',
        cover: '',
        catalog: 'magic',
        summary: 'the story is about dragon and magic'
    }
]

type BookData = typeof listData[0]

export const BookList: React.FC = (props) => {
    return (
        <FlatList
            contentContainerStyle={styles.container}
            columnWrapperStyle={styles.bookTile}
            data={listData}
            renderItem={({item}) => bookTile(item)}
        //Setting the number of column
        numColumns={3}
        keyExtractor={(item, index) => index.toString()}
      />
    )
}

function bookTile(bookData: BookData) {
    return (
        <View style={styles.bookTile}>
            <Image style={{ width: 'auto', height: 80 }} 
                source={require('../../assets/no-img.png')}
            />
            <Text>{bookData.title}</Text>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        justifyContent: 'space-evenly'
    },
    bookTile: {
        backgroundColor: 'red',
        borderColor: 'black',
        justifyContent: 'space-evenly'
    }
})