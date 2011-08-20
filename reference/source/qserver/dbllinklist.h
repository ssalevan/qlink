/***************************************************************************
                          dbllinklist.h  -  description
                             -------------------
    begin                : Sat Oct 20 2001
    copyright            : (C) 2001 by Keith Henrickson
    email                : flipper@phin.com
 ***************************************************************************/

/**This is the doubly linked list class.
It is pretty simple, but it will make
tracking lists of all these objects
relatively easy.  It simply stores a
doubly linked list of DblLinkListItem
  *@author Keith Henrickson
  */
#include "dbllinklistitem.h"

#ifndef DBLLINKLIST
#define DBLLINKLIST
template <class Type>
class DblLinkList {
public:
	DblLinkList() {
		pHead = NULL;
		pTail = NULL;
	}
	~DblLinkList() {
	}
  /** No descriptions */
void DeleteItem (DblLinkListItem<Type>* pDelItem) {
	// Deleting the item is much trickier
	if (pHead == pTail) {
		// This is the last item left in the list
		pHead = NULL;
		pTail = NULL;
	} else {
		if (pDelItem == pHead) {
			// This is the last (oldest) item in the list, so it has no prev
			printf("1\n");
			pHead = pDelItem->pNext;
		} else {
			printf("2\n");
			pDelItem->pPrev->pNext = pDelItem->pNext;  // Go back one and set it's next pointer to our next pointer
		}	
		if (pDelItem == pTail) {
			printf("3\n");
			// This is the first (newest) item in the list, so it has no next
			pTail = pDelItem->pPrev;
		} else {
			printf("4\n");
			pDelItem->pNext->pPrev = pDelItem->pPrev;  // And set the next item's prev pointer to our prev pointer
		}
	}
}

  /** No descriptions */
  void AddItem (DblLinkListItem<Type>* pAddItem) {
	pAddItem->pNext = NULL;  // Nothing after this item
	pAddItem->pPrev = pTail; // Whatever the tail is is right before this
	if (NULL == pHead) {
		// The list was empty
		pHead = pAddItem;
	} else {
		pTail->pNext    = pAddItem; // And now the next thing after the tail is this
	}
	pTail           = pAddItem; // And the tail is this
  }

  /** This gets a pointer for the tail of the list, where things are added. */
  DblLinkListItem<Type>* GetTail() {
  	return pTail;
  }

  /** No descriptions */
  DblLinkListItem<Type>* GetHead() {
  	return pHead;
  }

private: // Private attributes
  /** This is the pointer to the head of the list */
  DblLinkListItem<Type>* pHead;
  /** This is the pointer to the tail of the list */
  DblLinkListItem<Type>* pTail;
};
#endif