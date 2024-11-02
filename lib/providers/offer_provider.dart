import 'package:ecommerce_test/models/offers/OfferModel.dart';
import 'package:ecommerce_test/repositories/offer_repository.dart';

class OfferProvider {
  final OfferRepository _offerRepository;

  OfferProvider(this._offerRepository);

  Future<List<OfferModel>> getOffers() async {
    var offers = await _offerRepository.getOffers();

    return offers.map((offer) => OfferModel.fromJson(offer)).toList();
  }
}
