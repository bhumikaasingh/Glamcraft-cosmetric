
 
import 'package:final_assignment/features/product/domain/entity/product_entiry.dart';

class ProductTestData {
  ProductTestData._();
 
  static List<ProductEntiry> getProductTestData() {
    List<ProductEntiry> lstProducts = [
      const ProductEntiry(
        productId: "66844a14ddeed247f18d07b1",
        productName: "Lakme Maskara",
        productPrice: 5000,
        productCategory: "Cosmetrics",
        productImage: "1720649309981-maskara.jpg",
        productDescription:"This is a product description of lakme maskara",
        createdAt: "2024-07-02T18:42:28.062+00:00",
      ),
      const ProductEntiry(
        productId: "66844c5ab51bc68060b9ff48",
        productName: " Lipstick",
        productPrice: 700,
        productCategory: "Cosmetrics",
        productImage: "1719946330762-Lipstick.avif",
        productDescription:"This is a product description of lipstick ",
        createdAt: "2024-07-02T18:52:10.771+00:00",
      ),
      const ProductEntiry(
        productId: "66844e78b51bc68060b9ff60",
        productName: "Fixdarma Sunscream",
        productPrice: 1000,
        productCategory: "Cosmetrics",
        productImage: "1719946872505-Sunscream.jpg",
        productDescription:"This is a product description of Sunscream ",
        createdAt: "2024-07-02T19:01:12.508+00:00",
      ),
     const ProductEntiry(
        productId: "66844a14ddeed247f18d07b1",
        productName: "Lakme Maskara",
        productPrice: 5000,
        productCategory: "Cosmetrics",
        productImage: "1720649309981-maskara.jpg",
        productDescription:"This is a product description of lakme maskara",
        createdAt: "2024-07-02T18:42:28.062+00:00",
      ),
    ];
 
    return lstProducts;
  }
}
 