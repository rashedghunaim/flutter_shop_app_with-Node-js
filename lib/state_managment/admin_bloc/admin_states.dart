abstract class AdminTransactionsStates {}

class AdminTransactionInitialState extends AdminTransactionsStates {}

class AddNewProductSuccessState extends AdminTransactionsStates {}

class AddNewproductErrorState extends AdminTransactionsStates {}

class FetchAllproductsSuccessState extends AdminTransactionsStates {}

class FetchAllproductsErrorState extends AdminTransactionsStates {}

class FetchProductsWaitingState extends AdminTransactionsStates {}

class DeleteProductSuccessState extends AdminTransactionsStates {
  final String productID;
  DeleteProductSuccessState({required this.productID});
}

class DeleteProductErrorState extends AdminTransactionsStates {}

class FecthAllUsersOrdersSuccessState extends AdminTransactionsStates {}

class FecthAllUsersOrdersErrorState extends AdminTransactionsStates {}

class ChangeOrderStateSuccessState extends AdminTransactionsStates {}

class ChangeOrderStateErrorState extends AdminTransactionsStates {}

class CollectTotalEraningsSuccessState extends AdminTransactionsStates {}

class CollectTotalEraningsErrorState extends AdminTransactionsStates {}
