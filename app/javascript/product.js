var minus = document.querySelector(".btn-subtract")
var add = document.querySelector(".btn-add");
var quantity = document.querySelector(".item-quantity");
const minimum = 1;
const maximum = 49;

const productQuantity = () => {
  if (minus) {
    minus.addEventListener("click", function () {
      if (quantity.value <= minimum) {
        minus.disabled = true;
        return; // return to avoid decrementing
      } else {
          minus.disabled = false;
      }
      quantity.value--;
      if (quantity.value <= maximum) {
        add.disabled = false;
      }
    });
    add.addEventListener("click", function () {
    quantity.value++;
    if (quantity.value > minimum) {
      minus.disabled = false;
    }
    if (quantity.value > maximum) {
      add.disabled = true;
    }
  });
  }
}

export { productQuantity}
