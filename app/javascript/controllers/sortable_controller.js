import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js";
import Sortable from 'sortablejs';

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String
  }
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue
    });
  }
  onEnd(event) {
   
    // console.log(event.newIndex)
    // // console.log(sortableListId)
    // put(`lcongviec_trangthais/${event.item.dataset.sortableId}/sort`, {
    //   body: JSON.stringify({row_order_position: event.newIndex}),
    // })
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    var newIndex = event.newIndex
    var sortableListId = event.to.dataset.sortableListId
    console.log(sortableUpdateUrl)
    console.log(newIndex)
    console.log(sortableListId)
    put(sortableUpdateUrl, {
      body: JSON.stringify({row_order_position: newIndex, list_id: sortableListId}),
    })
  }
}
