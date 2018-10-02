//
//  Usage.swift
//  Hixel IOS App
//
// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).
import Foundation

/*
 @POST("/login")
 @Headers("No-Authentication: true")
 Call<Void> login(@Body LoginData request);
 
 @POST("/users/sign-up")
 @Headers("No-Authentication: true")
 Call<Void> signup(@Body ApplicationUser request);
 
 @GET("/users/refresh")
 Call<Void> refreshAccessToken(@Header("Refresh") String Refresh);
 
 @GET("/companydata")
 Call<ArrayList<Company>> doGetCompanies(@Query("tickers") String tickers, @Query("years") int years);
 
 @GET("/search")
 Single<List<SearchEntry>> doSearchQuery(@Query("query") String query);
*/

enum API {}

extension API {
    static func getCustomer() -> Endpoint<Void> {
        return Endpoint(
            method: .post,
            path: "/login"
        )
    }
    
    static func patchCustomer(name: String) -> Endpoint<Customer> {
        return Endpoint(
            method: .patch,
            path: "users/sign-up",
            parameters: ["name" : name]
        )
    }
}
