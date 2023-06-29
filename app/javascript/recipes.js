document.addEventListener("turbolinks:load", function() {
    const togglePublic = document.querySelector(".toggle-public");
  
    togglePublic.addEventListener("change", function() {
      const recipeId = this.getAttribute("data-recipe-id");
  
      Rails.ajax({
        url: "/recipes/" + recipeId + "/toggle_public",
        type: "PATCH",
        data: "public=" + this.checked,
        success: function() {
          console.log("Recipe public status updated successfully!");
        },
        error: function() {
          console.log("An error occurred while updating the recipe public status.");
        }
      });
    });
  });
  
  