CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" INTEGER NOT NULL CHECK("gluten_free" IN (0, 1)),
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "includes" (
    "ingredient_id" INTEGER,
    "donut_id" INTEGER,
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "order_history" (
    "customer_id" INTEGER,
    "order_Id" INTEGER,
    "datetime" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("order_number")
);

CREATE TABLE "orders" (
    "order_number" INTEGER,
    "customer_id" INTEGER,
    PRIMARY KEY("order_number"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "ordered_donuts" (
     "order_id" INTEGER,
     "donut_id" INTEGER,
     FOREIGN KEY("order_id") REFERENCES "orders"("order_number"),
     FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);
