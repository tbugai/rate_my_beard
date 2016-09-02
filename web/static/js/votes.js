class Votes {
  static init() {
    $("[data-field]").on("click", function(event) {
      event.preventDefault()
      event.stopPropagation()

      let $link = $(event.currentTarget)
      $.ajax({
        type: "POST",
        url: $link.attr("href"),
        data: null,
        dataType: "json"
      }).done(function(data) {
        let field = $link.data("field")
        $link.find("span").html(data.entry[field])
      })
    })
  }
}

export default Votes
