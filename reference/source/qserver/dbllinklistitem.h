/***************************************************************************
                          dbllinklistitem.h  -  description
                             -------------------
    begin                : Sat Oct 20 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

/**This is the item type for DblLinkList.
It will use templates so that it can store pointers to many
different objects.
  *@author Keith Henrickson
  */

#ifndef DBLLINKLISTITEM
#define DBLLINKLISTITEM
template <class Type>
class DblLinkListItem {
public: 
	DblLinkListItem();
	~DblLinkListItem();
public: // Public attributes
  /** Pointer to the next item in the list */
  DblLinkListItem* pNext;
  /** Pointer to the previous item in a list. */
  DblLinkListItem* pPrev;
  /** Pointer to the item stored at this position in the list. */
  Type            Item;
};

template <class Type>
DblLinkListItem<Type>::DblLinkListItem(){
}

template <class Type>
DblLinkListItem<Type>::~DblLinkListItem(){
}
#endif