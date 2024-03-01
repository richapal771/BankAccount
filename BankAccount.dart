import 'dart:io';
import 'dart:math';

class BankAccount {
  String name;
  String mobileNumber;
  String accountNumber;
  String pin;
  double balance;
  List<double> depositHistory = [];
  List<double> withdrawalHistory = [];

  BankAccount({
    required this.name,
    required this.mobileNumber,
    required this.accountNumber,
    required this.pin,
    this.balance = 0.0,
  });

  void showOptions() {
    while (true) {
      print("\nWelcome, $name");
      print("\nChoose an option:");
      print("1. Withdraw money");
      print("2. Change PIN number");
      print("3. Deposit money");
      print("4. Mini statement");
      print("5. Log out");
      var option = int.tryParse(stdin.readLineSync() ?? '');
      switch (option) {
        case 1:
          withdrawMoney();
          break;
        case 2:
          changePIN();
          break;
        case 3:
          depositMoney();
          break;
        case 4:
          miniStatement();
          break;
        case 5:
          print("You Have Successfully Log Out From Our Bank...!");
          return;
        default:
          print("Invalid option... Please choose again...!");
          break;
      }
    }
  }

  void withdrawMoney() {
    print("Enter amount to withdraw:");
    var amount = double.tryParse(stdin.readLineSync() ?? '');
    if (amount != null && amount > 0 && amount <= balance) {
      balance -= amount;
      withdrawalHistory.add(amount);
      print("Withdrawal successful. Remaining balance: $balance");
    } else {
      print("Invalid amount...insufficient balance...!");
    }
  }

  void changePIN() {
    print("Enter your current PIN:");
    var currentPIN = stdin.readLineSync() ?? '';
    if (currentPIN == pin) {
      print("Enter your new PIN:");
      var newPIN = stdin.readLineSync() ?? '';
      if (newPIN.length == 4 && isNumeric(newPIN)) {
        pin = newPIN;
        print("PIN changed successfully...!!");
      } else {
        print("Invalid PIN format... PIN should be a 4-digit number...!!");
      }
    } else {
      print("Incorrect current PIN.");
    }
  }

  void depositMoney() {
    print("Enter amount to deposit:");
    var amount = double.tryParse(stdin.readLineSync() ?? '');
    if (amount != null && amount > 0) {
      balance += amount;
      depositHistory.add(amount);
      print("Deposit successful...");
      print('Updated balance: $balance');
    } else {
      print("Invalid amount.");
    }
  }

  void miniStatement() {
    print("Mini Statement:");
    print("Account Number: $accountNumber");
    print("Name: $name");
    print("Mobile Number: $mobileNumber");
    print("Balance: $balance");
    print("Withdrawal History:");
    for (var withdrawal in withdrawalHistory) {
      print("- $withdrawal");
    }
    print("Deposit History:");
    for (var deposit in depositHistory) {
      print("+ $deposit");
    }
  }
}

void main() {
  var accountDetails = <String, BankAccount>{};

  while (true) {
    print("Welcome To RP Bank...!");
    print("Do you have an account in our bank? (yes/no)");
    var response = stdin.readLineSync()?.toLowerCase() ?? '';
    if (response == 'yes') {
      print("Enter your bank account number:");
      var accountNumber = stdin.readLineSync() ?? '';
      if (!accountDetails.containsKey(accountNumber)) {
        print("Account not found...Please check your account number...!!");
        continue;
      }

      print("Enter your ATM PIN:");
      var pin = stdin.readLineSync() ?? '';
      var account = accountDetails[accountNumber]!;
      if (account.pin != pin) {
        print("Incorrect PIN...Please try again...!!");
        continue;
      }

      account.showOptions();
    } else if (response == 'no') {
      print("Enter your name:");
      String name = '';
      while (name.isEmpty) {
        var input = stdin.readLineSync() ?? '';
        if (isNumeric(input)) {
          print("Name is not Number...Please enter your name...!");
        } else {
          name = input;
        }
      }

      print("Enter your 10-digit mobile number:");
      String mobileNumber = '';
      while (mobileNumber.isEmpty) {
        var input = stdin.readLineSync() ?? '';
        if (!isNumeric(input) || input.length != 10) {
          print("Invalid mobile number...Please enter a 10-digit number...!");
        } else {
          mobileNumber = input;
        }
      }

      var accountNumber = generateAccountNumber();
      var pin = generatePIN();

      print("\nAccount created successfully!");
      print("Name: $name");
      print("Mobile Number: $mobileNumber");
      print("Account Number: $accountNumber");
      print("PIN: $pin");

      var newAccount = BankAccount(
        name: name,
        mobileNumber: mobileNumber,
        accountNumber: accountNumber,
        pin: pin,
      );
      accountDetails[accountNumber] = newAccount;

      newAccount.showOptions();
    } else {
      print("Invalid response...Please type'yes' or 'no'...!");
    }
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String generateAccountNumber() {
  var random = Random();
  var accountNumber = '';
  for (var i = 0; i < 12; i++) {
    accountNumber += random.nextInt(9).toString();
  }
  return accountNumber;
}

String generatePIN() {
  var random = Random();
  var pin = '';
  for (var i = 0; i < 4; i++) {
    pin += random.nextInt(10).toString();
  }
  return pin;
}
