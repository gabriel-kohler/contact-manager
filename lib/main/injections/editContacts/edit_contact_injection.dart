import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_test/infrastructure/http_adapter.dart';

import '../../../core/core.dart';
import '../../../core/loadUser/load_user.dart';
import '../../../infrastructure/cordinator_adapter.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../presentation/presentation.dart';
import '../../../screens/pages/pages.dart';
import '../../../validation/validation.dart';

ContactDetailPage makeContactDetailPage(
    EditContactUiController editContactUiController) =>
    ContactDetailPage(
      presenter: editContactUiController,
    );

ContactAddressDetailPage makeContactAddressDetailPage(
    EditContactUiController editContactUiController) =>
    ContactAddressDetailPage(
      presenter: editContactUiController,
    );

EditContactUiController makeEditContactUiController(
    LocalStorage storage, GeocodingPlatform geocoding) =>
    EditContactUiController(
      deleteContact: DeleteContactData(
        storage: LocalStorageAdapter(
          localStorage: storage,
        ),
      ),
      loadCordinates: LoadCordinatesFromAddress(
        cordinator: CordinatorAdapter(
          geocoding: geocoding,
        ),
      ),
      managerCurrentUser: LocalManagerCurrentUser(
        storage: LocalStorageAdapter(
          localStorage: storage,
        ),
      ),
      contactsManager: LocalContactsManager(
        storage: LocalStorageAdapter(
          localStorage: storage,
        ),
      ),
      validation: ValidationUIComposite(
        [
          ...ValidationUIBuilder.field('name').required().minLength(3).build(),
          ...ValidationUIBuilder.field('phoneNumber').required().build(),
          ...ValidationUIBuilder.field('cpf').required().cpf().build(),
          ...ValidationUIBuilder.field('cep').required().build(),
          ...ValidationUIBuilder.field('street').required().build(),
          ...ValidationUIBuilder.field('streetNumber').required().build(),
          ...ValidationUIBuilder.field('district').required().build(),
          ...ValidationUIBuilder.field('state').required().build(),
          ...ValidationUIBuilder.field('city').required().build(),
        ],
      ),
      zipCode: ZipCodeValidation(
        url: 'https://viacep.com.br/ws',
        httpClient: HttpAdapter(
          client: Client(),
        ),
      ),
    );