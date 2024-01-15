# Food and Drinks Order Flutter App

## Overview

This Flutter application is designed for ordering food and drinks. It includes features for browsing menus, applying vouchers, placing orders, and canceling orders. The app communicates with a server API to fetch menu data, process orders, and manage vouchers.

![alt text](https://raw.githubusercontent.com/whyaji/food-pos-flutter/main/ss-foodpos.jpg)

## Features

- **Browse Menus:** Explore a variety of food and drinks available in the menu. (Done)
- **Apply Vouchers:** Apply discount vouchers to your orders for additional savings. (Done)
- **Place Orders:** Easily place orders with selected items and custom notes.
- **Cancel Orders:** Cancel placed orders if needed.

## Installation

Make sure you have Flutter installed on your system. Clone the repository and run the following commands:

```bash
flutter pub get
flutter run
```

## Usage

1. Launch the app on your device or emulator.
2. Browse through the menus to select items you want to order.
3. Apply any available vouchers for discounts.
4. Place your order with custom notes for each item.
5. View and manage your orders in the order history.
6. Cancel orders if necessary.

## API Integration

The app communicates with a server API to fetch menu data, process orders, and manage vouchers. Ensure that the API is properly configured and accessible.

### Endpoints

- **Fetch Menus:** `GET https://tes-mobile.landa.id/api/menus`
- **Fetch Vouchers:** `GET https://tes-mobile.landa.id/api/vouchers?kode=puas`
- **Place Order:** `POST https://tes-mobile.landa.id/api/order`
- **Cancel Order:** `POST https://tes-mobile.landa.id/api/order/cancel/{id}`

## Dependencies

- [http](https://pub.dev/packages/http): For making HTTP requests to the server.
- [json_annotation](https://pub.dev/packages/json_annotation): For JSON serialization/deserialization.