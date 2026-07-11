const btn = document.getElementById("test-btn");
const msg = document.getElementById("msg");

if (btn && msg) {
  btn.addEventListener("click", function () {
    const now = new Date().toLocaleString("fr-CA");
    msg.textContent = "Interaction OK - test local execute le " + now;
  });
}
