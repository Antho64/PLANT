import 'package:flutter_tflite/flutter_tflite.dart';

class MLService {
  MLService() {
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
      );
      print('Model loaded successfully.');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<Map<String, String>> predictDisease(String imagePath) async {
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: imagePath,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.5,
        asynch: true,
      );

      print('Recognitions: $recognitions');

      if (recognitions != null && recognitions.isNotEmpty) {
        var disease = recognitions[0]['label'];
        var treatment = _getTreatment(disease);
        print('Disease: $disease, Treatment: $treatment');
        return {'disease': disease, 'treatment': treatment};
      } else {
        print('No recognitions found.');
        return {'disease': 'No disease detected', 'treatment': ''};
      }
    } catch (e) {
      print('Error predicting disease: $e');
      return {'disease': 'Error', 'treatment': 'Error predicting disease.'};
    }
  }

  String _getTreatment(String disease) {
    print('Received disease label: $disease');

    // Normalize disease label for matching
    disease = disease.toLowerCase().trim(); // Convert to lowercase and trim whitespace

    switch (disease) {
      case 'apple apple scab':
        return 'Apple Scab: Remove and destroy fallen leaves and infected fruit. Prune trees to allow better air circulation. Apply fungicides in early spring, beginning at green tip and continuing until 2 weeks after petal fall. Choose scab-resistant varieties when planting new trees.';
      case 'apple black rot':
        return 'Apple Black Rot: Prune and destroy infected branches and mummified fruits. Apply appropriate fungicides in the spring and early summer. Keep trees healthy with proper fertilization and watering.';
      case 'apple cedar apple rust':
        return 'Apple Cedar Apple Rust: Remove galls from nearby cedar trees. Apply fungicides to apple trees starting when leaves begin to show. Select resistant apple varieties.';
      case 'apple healthy':
        return 'No treatment needed. Your apple tree is healthy!';
      case 'blueberry healthy':
        return 'No treatment needed. Your blueberry plant is healthy!';
      case 'cherry including sour powdery mildew':
        return 'Cherry Powdery Mildew: Remove and destroy infected leaves. Apply sulfur or other fungicides labeled for powdery mildew. Ensure proper spacing and pruning to improve air circulation.';
      case 'cherry including sour healthy':
        return 'No treatment needed. Your cherry plant is healthy!';
      case 'corn maize cercospora leaf spot gray leaf spot':
        return 'Corn Gray Leaf Spot: Rotate crops and avoid planting corn in the same field year after year. Remove crop residues from the field. Apply fungicides if disease pressure is high and weather conditions favor disease development.';
      case 'corn maize common rust':
        return 'Corn Common Rust: Plant resistant varieties of corn. Apply fungicides if necessary, especially during warm, humid weather. Rotate crops to reduce disease inoculum.';
      case 'corn maize northern leaf blight':
        return 'Corn Northern Leaf Blight: Use resistant hybrids. Apply fungicides if necessary, especially during periods of wet weather. Practice crop rotation and remove infected crop residues.';
      case 'corn maize healthy':
        return 'No treatment needed. Your corn plant is healthy!';
      case 'grape black rot':
        return 'Grape Black Rot: Remove and destroy infected grapes and leaves. Apply fungicides starting at bud break and continue through the growing season. Ensure proper pruning and spacing to improve air circulation.';
      case 'grape esca black measles':
        return 'Grape Esca (Black Measles): Prune and destroy infected vines. Apply fungicides, particularly in spring and early summer. Minimize vine stress by proper watering and fertilization.';
      case 'grape leaf blight isariopsis leaf spot':
        return 'Grape Leaf Blight (Isariopsis Leaf Spot): Remove and destroy infected leaves. Apply appropriate fungicides. Ensure proper air circulation through pruning and spacing.';
      case 'grape healthy':
        return 'No treatment needed. Your grapevine is healthy!';
      case 'orange haunglongbing citrus greening':
        return 'Orange Huanglongbing (Citrus Greening): Remove and destroy infected trees. Control the Asian citrus psyllid vector using insecticides. Plant disease-free nursery stock and use resistant rootstocks where available.';
      case 'peach bacterial spot':
        return 'Peach Bacterial Spot: Remove and destroy infected leaves and fruits. Apply copper-based bactericides. Choose resistant varieties and maintain tree vigor through proper watering and fertilization.';
      case 'peach healthy':
        return 'No treatment needed. Your peach tree is healthy!';
      case 'pepper bell bacterial spot':
        return 'Pepper Bacterial Spot: Remove and destroy infected leaves. Apply copper-based bactericides. Rotate crops and avoid planting peppers in the same location each year.';
      case 'pepper bell healthy':
        return 'No treatment needed. Your pepper plant is healthy!';
      case 'potato early blight':
        return 'Potato Early Blight: Remove and destroy infected leaves. Apply fungicides, especially during wet weather. Rotate crops and avoid overhead watering to reduce leaf wetness.';
      case 'potato late blight':
        return 'Potato Late Blight: Remove and destroy infected plants. Apply fungicides regularly during the growing season. Avoid overhead watering and ensure proper spacing to improve air circulation.';
      case 'potato healthy':
        return 'No treatment needed. Your potato plant is healthy!';
      case 'raspberry healthy':
        return 'No treatment needed. Your raspberry plant is healthy!';
      case 'soybean healthy':
        return 'No treatment needed. Your soybean plant is healthy!';
      case 'squash powdery mildew':
        return 'Squash Powdery Mildew: Remove and destroy infected leaves. Apply fungicides labeled for powdery mildew. Ensure proper spacing and improve air circulation by pruning.';
      case 'strawberry leaf scorch':
        return 'Strawberry Leaf Scorch: Remove and destroy infected leaves. Avoid overhead watering. Apply fungicides if necessary, particularly during wet weather.';
      case 'strawberry healthy':
        return 'No treatment needed. Your strawberry plant is healthy!';
      case 'tomato bacterial spot':
        return 'Tomato Bacterial Spot: Remove and destroy infected leaves. Apply copper-based bactericides. Avoid overhead watering and handle plants when dry to reduce spread.';
      case 'tomato early blight':
        return 'Tomato Early Blight: Remove and destroy infected leaves. Apply fungicides, especially during wet weather. Rotate crops and avoid planting tomatoes in the same location each year.';
      case 'tomato late blight':
        return 'Tomato Late Blight: Remove and destroy infected plants. Apply fungicides regularly during the growing season. Avoid overhead watering and ensure proper spacing to improve air circulation.';
      case 'tomato leaf mold':
        return 'Tomato Leaf Mold: Remove and destroy infected leaves. Improve air circulation through proper spacing and pruning. Apply fungicides labeled for leaf mold.';
      case 'tomato septoria leaf spot':
        return 'Tomato Septoria Leaf Spot: Remove and destroy infected leaves. Avoid overhead watering. Apply fungicides if necessary, particularly during wet weather.';
      case 'tomato spider mites two spotted spider mite':
        return 'Tomato Spider Mites: Remove and destroy infected leaves. Apply miticides or insecticidal soap. Ensure proper watering to reduce plant stress.';
      case 'tomato target spot':
        return 'Tomato Target Spot: Remove and destroy infected leaves. Apply fungicides labeled for target spot. Ensure proper air circulation and avoid overhead watering.';
      case 'tomato tomato yellow leaf curl virus':
        return 'Tomato Yellow Leaf Curl Virus: Remove and destroy infected plants. Control whitefly vectors using insecticides. Plant resistant varieties where available.';
      case 'tomato tomato mosaic virus':
        return 'Tomato Mosaic Virus: Remove and destroy infected plants. Avoid handling plants when wet. Plant resistant varieties and sanitize tools to prevent spread.';
      case 'tomato healthy':
        return 'No treatment needed. Your tomato plant is healthy!';
      default:
        print('No matching treatment found for: $disease');
        return 'No treatment information available for $disease';
    }
  }
}
