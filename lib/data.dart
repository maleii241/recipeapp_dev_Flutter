class Recipe {

  String title;
  String description;
  String image;
  int calories;
  int carbo;
  int protein;

  Recipe(this.title, this.description, this.image, this.calories, this.carbo, this.protein);

}

List<Recipe> getRecipes(){
  return <Recipe>[
    Recipe("Жареное мясо", "Так неотразимо вкусно", "assets/images/chicken_fried_rice.png", 250, 35, 6),
    Recipe("Паста Болоньезе", "Итальянская классика с мясным соусом чили", "assets/images/pasta_bolognese.png", 200, 45, 10),
    Recipe("Картофель с чесноком", "Жареный картофель с хрустящим чесноком", "assets/images/filete_con_papas_cambray.png", 150, 30, 8),
    Recipe("Мясо с грибами", "Хорошо приготовленное мясо - это безумно вкусно", "assets/images/asparagus.png", 190, 35, 12),
    Recipe("Филе Миньон", "Филе Миньон в беконе", "assets/images/steak_bacon.png", 250, 55, 20),
  ];
}