-- ----------------------------
--  Table structure for trips
-- ----------------------------
DROP TABLE IF EXISTS "public"."trips";
CREATE TABLE "public"."trips" (
	"id" int4 NOT NULL,
	"client_id" int4 NOT NULL,
	"driver_id" int4 NOT NULL,
	"status" varchar NOT NULL COLLATE "default",
	"request_at" date NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."trips" OWNER TO "viewthespace";

-- ----------------------------
--  Records of trips
-- ----------------------------
BEGIN;
INSERT INTO "public"."trips" VALUES ('1', '1', '10', 'completed', '2015-09-25');
INSERT INTO "public"."trips" VALUES ('2', '2', '11', 'cancelled_by_driver', '2015-09-25');
INSERT INTO "public"."trips" VALUES ('3', '3', '12', 'completed', '2015-09-25');
INSERT INTO "public"."trips" VALUES ('4', '4', '13', 'cancelled_by_client', '2015-09-25');
INSERT INTO "public"."trips" VALUES ('5', '1', '10', 'completed', '2015-09-26');
INSERT INTO "public"."trips" VALUES ('6', '2', '11', 'completed', '2015-09-26');
INSERT INTO "public"."trips" VALUES ('7', '3', '12', 'completed', '2015-09-26');
INSERT INTO "public"."trips" VALUES ('8', '2', '12', 'completed', '2015-09-27');
INSERT INTO "public"."trips" VALUES ('9', '3', '10', 'completed', '2015-09-27');
INSERT INTO "public"."trips" VALUES ('10', '4', '13', 'cancelled_by_driver', '2015-09-27');
COMMIT;

-- ----------------------------
--  Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
	"id" int4 NOT NULL,
	"banned" bool NOT NULL,
	"role" varchar NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "public"."users" OWNER TO "viewthespace";

-- ----------------------------
--  Records of users
-- ----------------------------
BEGIN;
INSERT INTO "public"."users" VALUES ('1', 'f', 'client');
INSERT INTO "public"."users" VALUES ('2', 't', 'client');
INSERT INTO "public"."users" VALUES ('3', 'f', 'client');
INSERT INTO "public"."users" VALUES ('4', 'f', 'client');
INSERT INTO "public"."users" VALUES ('5', 'f', 'driver');
INSERT INTO "public"."users" VALUES ('6', 'f', 'driver');
INSERT INTO "public"."users" VALUES ('7', 'f', 'driver');
INSERT INTO "public"."users" VALUES ('8', 'f', 'driver');
COMMIT;

-- ----------------------------
--  Primary key structure for table trips
-- ----------------------------
ALTER TABLE "public"."trips" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table trips
-- ----------------------------
CREATE INDEX  "trips_client_id_index" ON "public"."trips" USING btree(client_id ASC NULLS LAST);
CREATE INDEX  "trips_driver_id_index" ON "public"."trips" USING btree(driver_id ASC NULLS LAST);
CREATE INDEX  "trips_request_at_index" ON "public"."trips" USING btree(request_at ASC NULLS LAST);
CREATE INDEX  "trips_status_index" ON "public"."trips" USING btree(status COLLATE "default" ASC NULLS LAST);

-- ----------------------------
--  Primary key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------
--  Indexes structure for table users
-- ----------------------------
CREATE INDEX  "users_banned_index" ON "public"."users" USING btree(banned ASC NULLS LAST);
CREATE INDEX  "users_role_index" ON "public"."users" USING btree("role" COLLATE "default" ASC NULLS LAST);

