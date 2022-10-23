package com.example.electionbasic;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.example.electionbasic.databinding.ActivityMainBinding;

import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.DefaultBlockParameter;
import org.web3j.protocol.core.DefaultBlockParameterName;
import org.web3j.protocol.core.methods.response.EthGetBalance;
import org.web3j.protocol.core.methods.response.EthLog;
import org.web3j.protocol.core.methods.response.Web3ClientVersion;
import org.web3j.protocol.http.HttpService;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class MainActivity extends AppCompatActivity {

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
        Log.d("main", "onCreate: ");

//        final Web3j client = Web3j.build(new HttpService("HTTP://127.0.0.1:7545"));
//        final String address = "0xd5DB2F7Ad829964039d0bD922c4fF07FeeE2475e";
//        final EthGetBalance balance;
//        try {
//            balance = client.ethGetBalance(address, DefaultBlockParameter.valueOf("latest")).sendAsync().get(10, TimeUnit.SECONDS);
//            final BigInteger unscaledBalance = balance.getBalance();
//            final BigDecimal scaledBalance = new BigDecimal(unscaledBalance).divide(new BigDecimal(1000000000000000000L), 18, RoundingMode.HALF_UP);
//            binding.balance.setText("" + scaledBalance);
//            Log.d("balance", "onCreate: " + scaledBalance);
//        } catch (ExecutionException e) {
//            e.printStackTrace();
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        } catch (TimeoutException e) {
//            e.printStackTrace();
//        }


        Web3j web3 = Web3j.build(new HttpService("https://rinkeby.infura.io/v3/0a4456acb4734a9f8664bbc7876e6fcc"));



        try {
            EthGetBalance ethGetBalance = web3.ethGetBalance("0x665a228fC8fFC785be72C7c3dD7D9c7096eCd5d6", DefaultBlockParameterName.LATEST).sendAsync().get();
            BigInteger balance = ethGetBalance.getBalance();
            BigDecimal scaledBalance = new BigDecimal(balance).divide(new BigDecimal(1000000000000000000L), 18, RoundingMode.HALF_UP).setScale(5, BigDecimal.ROUND_UP);
            Log.d("main", "onCreate: " + scaledBalance);
            binding.balance.setText("" + web3.web3ClientVersion().sendAsync().get().getWeb3ClientVersion());

//            web3ClientVersion = web3.web3ClientVersion().sendAsync().get();
//

        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        String clientVersion = web3ClientVersion.getWeb3ClientVersion();
//
//
//        binding.balance.setText("" + clientVersion);


        binding.rahul.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showAlertDialog("Rahul");
            }
        });
        binding.rahul.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showAlertDialog("Rohit");
            }
        });


    }

    private void showAlertDialog(String name) {
        new AlertDialog.Builder(this)
                .setTitle("Do you want to vote for " + name)
                .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                }).setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                }).create().show();
    }
}