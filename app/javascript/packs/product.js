var minus = document.querySelector(".btn-subtract")
var add = document.querySelector(".btn-add");
var quantity = document.querySelector(".item-quantity");
var product_total = parseInt(document.getElementById('total_quantity').dataset.inventory);
const minimum = 1;

minus.addEventListener("click", function () {
  quantity.value--;
  if (quantity.value <= minimum) {
    minus.disabled = true;
    return; // return to avoid decrementing
  } else {
    minus.disabled = false;
  }
  if (quantity.value <= product_total) {
    add.disabled = false;
  }
});
add.addEventListener("click", function () {
  quantity.value++;
  if (quantity.value > minimum) {
    minus.disabled = false;
  }
  if (quantity.value >= product_total) {
    add.disabled = true;
  }
});
