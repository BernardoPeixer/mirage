import 'dart:math';

import 'package:mirage/default/constants.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:web3dart/crypto.dart';
import 'package:http/http.dart' as http;

/// Service to interact with PYUSD token and Mediator contract using
/// WalletConnect (ReownAppKit).
class WalletService {
  /// Creates a WalletService using the given ReownAppKit modal.
  WalletService(this._appKitModal);

  final ReownAppKitModal _appKitModal;

  /// Returns the current session topic.
  String? get topic => _appKitModal.session?.topic;

  /// Returns the connected wallet address or null if not connected.
  String? get walletAddress {
    final fullAddress = _appKitModal.session?.getAddress('eip155');
    if (fullAddress == null) return null;
    return fullAddress.split(':').last;
  }

  /// Returns the token balance of [walletAddress] for PYUSD.
  Future<BigInt> getBalanceDirect(String walletAddress) async {
    final client = Web3Client(Constants.rpcUrl, http.Client());
    final tokenContract = DeployedContract(
      ContractAbi.fromJson(Constants.erc20Abi, 'ERC20'),
      EthereumAddress.fromHex(Constants.pyusdToken),
    );

    final balanceFn = tokenContract.function('balanceOf');
    final balanceRes = await client.call(
      contract: tokenContract,
      function: balanceFn,
      params: [EthereumAddress.fromHex(walletAddress)],
    );

    return balanceRes[0] as BigInt;
  }

  /// Returns the allowance the [spenderAddress] has for [walletAddress] on
  /// the token contract.
  Future<BigInt> getAllowance({
    required String walletAddress,
    required String spenderAddress,
    String tokenAddress = Constants.pyusdToken,
  }) async {
    final tokenContract = DeployedContract(
      ContractAbi.fromJson(Constants.erc20Abi, 'ERC20'),
      EthereumAddress.fromHex(tokenAddress),
    );

    final allowanceFn = tokenContract.function('allowance');
    final result = await Web3Client(Constants.rpcUrl, http.Client()).call(
      contract: tokenContract,
      function: allowanceFn,
      params: [
        EthereumAddress.fromHex(walletAddress),
        EthereumAddress.fromHex(spenderAddress),
      ],
    );

    return result[0] as BigInt;
  }

  /// Sends an approval transaction via WalletConnect for the [spender] to spend
  /// [amount] of the token.
  Future<String?> approveSpenderModal({
    required String spender,
    required BigInt amount,
    required int chainId,
    String tokenAddress = Constants.pyusdToken,
  }) async {
    if (walletAddress == null) return null;

    final funcData = _encodeFunction(
      functionName: 'approve',
      parameters: [
        FunctionParameter('spender', AddressType()),
        FunctionParameter('amount', UintType()),
      ],
      args: [EthereumAddress.fromHex(spender), amount],
    );

    final txParams = {
      'from': walletAddress!,
      'to': tokenAddress,
      'data': funcData,
      'gas': '0x3D090',
    };

    final result = await _appKitModal.request(
      topic: topic,
      chainId: 'eip155:$chainId',
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [txParams],
      ),
    );

    return result?.toString();
  }

  /// Transfers [amount] of PYUSD to [recipient] via the mediator contract.
  /// Generates a unique orderId to avoid duplicate transactions.
  Future<String?> transferPYUSD({
    required String mediatorContract,
    required String recipient,
    required BigInt amount,
    required int chainId,
  }) async {
    if (walletAddress == null) return null;

    final orderId =
        BigInt.from(DateTime.now().millisecondsSinceEpoch) +
        BigInt.from(Random().nextInt(1000000));

    try {
      final funcData = _encodeFunction(
        functionName: 'transferPYUSD',
        parameters: [
          FunctionParameter('recipient', AddressType()),
          FunctionParameter('amount', UintType()),
          FunctionParameter('orderId', UintType()),
        ],
        args: [EthereumAddress.fromHex(recipient), amount, orderId],
      );

      final txParams = {
        'from': walletAddress!,
        'to': mediatorContract,
        'data': funcData,
        'gas': '0x3D090',
      };

      final result = await _appKitModal.request(
        topic: topic,
        chainId: 'eip155:$chainId',
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [txParams],
        ),
      );

      return result?.toString();
    } catch (e) {
      throw Exception('Erro ao assinar contrato');
    }
  }

  /// Encodes a smart contract function call with parameters and arguments.
  String _encodeFunction({
    required String functionName,
    required List<FunctionParameter> parameters,
    required List<dynamic> args,
  }) {
    final func = ContractFunction(functionName, parameters);

    final encoded = func.encodeCall(args);

    return bytesToHex(encoded, include0x: true);
  }
}

/// Parses a string value representing PYUSD and converts it to the token's
/// smallest unit (BigInt).
BigInt parsePYUSD(String valueStr) {
  final value = double.parse(valueStr);
  final intValue = (value * 1e6).toInt();
  return BigInt.from(intValue);
}
