/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.0.159-测试
 Source Server Type    : PostgreSQL
 Source Server Version : 140001 (140001)
 Source Host           : 192.168.0.159:5432
 Source Catalog        : feishuwg
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140001 (140001)
 File Encoding         : 65001

 Date: 22/08/2023 11:20:20
*/


-- ----------------------------
-- Sequence structure for global_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."global_config_id_seq";
CREATE SEQUENCE "public"."global_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for keypair_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."keypair_id_seq";
CREATE SEQUENCE "public"."keypair_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for mesh_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."mesh_id_seq";
CREATE SEQUENCE "public"."mesh_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for mesh_ip_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."mesh_ip_id_seq";
CREATE SEQUENCE "public"."mesh_ip_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 5147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for node_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."node_id_seq";
CREATE SEQUENCE "public"."node_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for global_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."global_config";
CREATE TABLE "public"."global_config" (
  "id" int4 NOT NULL DEFAULT nextval('global_config_id_seq'::regclass),
  "node_id" int4,
  "key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "val" varchar(255) COLLATE "pg_catalog"."default",
  "desc" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "updated_at" timestamp(6),
  "deleted" varchar(1) COLLATE "pg_catalog"."default" DEFAULT 0
)
;
COMMENT ON COLUMN "public"."global_config"."node_id" IS '节点id';
COMMENT ON COLUMN "public"."global_config"."deleted" IS '0未删除，1已删除';

-- ----------------------------
-- Records of global_config
-- ----------------------------
INSERT INTO "public"."global_config" VALUES (2, -1, 'GlobalAddress', 'https://192.168.0.232:8088', '主服务器外网地址', '2023-06-23 21:43:42', '2023-08-12 12:01:34.014192', '0');
INSERT INTO "public"."global_config" VALUES (4, -1, 'StartListenPort', '50000', '监听端口起始位置', '2023-06-29 19:57:30', '2023-08-12 12:01:34.014192', '0');
INSERT INTO "public"."global_config" VALUES (32, -1, 'SocketAesKey', 'ba3f8e06a341f82650a41b9380c78cdd', 'socket aes加密key', '2023-08-20 14:44:27', '2023-08-20 14:44:31', '0');
INSERT INTO "public"."global_config" VALUES (3, -1, 'AESKey', 'vH1q!fRBr&tVR~8En$5v5?1pJdV#vn)_', '默认aeskey', '2023-06-24 15:08:24', '2023-06-24 15:08:26', '0');
INSERT INTO "public"."global_config" VALUES (5, -1, 'DefaultAllowedIps', '0.0.0.0/0,::/0', '默认允许的ip', '2023-06-29 21:17:59', '2023-06-29 21:18:07', '0');
INSERT INTO "public"."global_config" VALUES (6, -1, 'DefaultMeshIpv4', '10.5.1.0/31', 'mesh默认ipv4地址段', '2023-06-29 21:34:04', '2023-07-15 03:58:46.853411', '0');
INSERT INTO "public"."global_config" VALUES (7, -1, 'DefaultMeshIpv6', 'FE80::10.5.1.0/64', 'mesh默认ipv6地址段', '2023-06-29 21:34:42', '2023-07-15 03:58:46.853411', '0');
INSERT INTO "public"."global_config" VALUES (31, -1, 'SocketPort', '8095', 'socket监听端口', '2023-07-18 22:09:32', '2023-07-18 22:09:36', '0');

-- ----------------------------
-- Table structure for keypair
-- ----------------------------
DROP TABLE IF EXISTS "public"."keypair";
CREATE TABLE "public"."keypair" (
  "id" int4 NOT NULL DEFAULT nextval('keypair_id_seq'::regclass),
  "private_key" varchar(255) COLLATE "pg_catalog"."default",
  "public_key" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "refresh" varchar(2) COLLATE "pg_catalog"."default" DEFAULT 1
)
;
COMMENT ON COLUMN "public"."keypair"."refresh" IS '是否需要刷新，1需要，0不需要';

-- ----------------------------
-- Records of keypair
-- ----------------------------

-- ----------------------------
-- Table structure for mesh
-- ----------------------------
DROP TABLE IF EXISTS "public"."mesh";
CREATE TABLE "public"."mesh" (
  "id" int4 NOT NULL DEFAULT nextval('mesh_id_seq'::regclass),
  "pri_key_id" int4,
  "addresses" varchar(255) COLLATE "pg_catalog"."default",
  "listen_port" int4,
  "mtu" int4,
  "physics_network_card" varchar(64) COLLATE "pg_catalog"."default",
  "post_up" varchar(255) COLLATE "pg_catalog"."default",
  "post_down" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "updated_at" timestamp(6),
  "preshared_key_id" int4,
  "allowed_ips" varchar(255) COLLATE "pg_catalog"."default",
  "persistent_keepalive" int4,
  "node_id" int4,
  "pub_key_id" int4,
  "conn_mesh_id" int4,
  "conn_node_id" int4,
  "del" varchar(5) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'N'::character varying,
  "cost" int4
)
;
COMMENT ON COLUMN "public"."mesh"."pri_key_id" IS '私钥id';
COMMENT ON COLUMN "public"."mesh"."addresses" IS '内网地址';
COMMENT ON COLUMN "public"."mesh"."post_up" IS 'json数组';
COMMENT ON COLUMN "public"."mesh"."post_down" IS 'json数组';
COMMENT ON COLUMN "public"."mesh"."preshared_key_id" IS '共享keyid';
COMMENT ON COLUMN "public"."mesh"."allowed_ips" IS '允许的ip';
COMMENT ON COLUMN "public"."mesh"."node_id" IS '节点ID';
COMMENT ON COLUMN "public"."mesh"."pub_key_id" IS '公钥id';
COMMENT ON COLUMN "public"."mesh"."conn_mesh_id" IS '对端meshid';
COMMENT ON COLUMN "public"."mesh"."conn_node_id" IS '对端nodeid';
COMMENT ON COLUMN "public"."mesh"."del" IS '是否删除';
COMMENT ON COLUMN "public"."mesh"."cost" IS '延迟';

-- ----------------------------
-- Records of mesh
-- ----------------------------

-- ----------------------------
-- Table structure for mesh_ip
-- ----------------------------
DROP TABLE IF EXISTS "public"."mesh_ip";
CREATE TABLE "public"."mesh_ip" (
  "id" int4 NOT NULL DEFAULT nextval('mesh_ip_id_seq'::regclass),
  "mesh_id" int4,
  "ip" varchar(255) COLLATE "pg_catalog"."default",
  "create_at" timestamp(6)
)
;

-- ----------------------------
-- Records of mesh_ip
-- ----------------------------

-- ----------------------------
-- Table structure for node
-- ----------------------------
DROP TABLE IF EXISTS "public"."node";
CREATE TABLE "public"."node" (
  "id" int4 NOT NULL DEFAULT nextval('node_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "endpoint" varchar(255) COLLATE "pg_catalog"."default",
  "node_status" int2 NOT NULL,
  "join_token" varchar(255) COLLATE "pg_catalog"."default",
  "create_at" timestamp(6) NOT NULL,
  "update_at" timestamp(6) NOT NULL,
  "join_at" timestamp(6),
  "audit_fail_reason" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "multi_conn" varchar(2) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'N'::character varying,
  "del" varchar(5) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'N'::character varying,
  "os" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "host_name" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
COMMENT ON COLUMN "public"."node"."node_type" IS '节点类型：master或slave';
COMMENT ON COLUMN "public"."node"."endpoint" IS '公网地址';
COMMENT ON COLUMN "public"."node"."node_status" IS '节点状态：0待入网，1审核中，2审核失败，3正常，4禁用';
COMMENT ON COLUMN "public"."node"."join_token" IS '入网令牌';
COMMENT ON COLUMN "public"."node"."join_at" IS '第一次入网时间';
COMMENT ON COLUMN "public"."node"."audit_fail_reason" IS '入网审核失败说明';
COMMENT ON COLUMN "public"."node"."multi_conn" IS '是否支持多连接';
COMMENT ON COLUMN "public"."node"."del" IS '是否删除';
COMMENT ON COLUMN "public"."node"."os" IS '系统信息';
COMMENT ON COLUMN "public"."node"."host_name" IS '主机信息';

-- ----------------------------
-- Records of node
-- ----------------------------
INSERT INTO "public"."node" VALUES (3, '主节点', 'master', '192.168.0.232', 3, '', '2023-06-26 17:06:11.744285', '2023-06-26 17:06:11.744285', '2023-06-26 17:06:11.744285', '', 'Y', 'N', '', '');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."global_config_id_seq"
OWNED BY "public"."global_config"."id";
SELECT setval('"public"."global_config_id_seq"', 32, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."keypair_id_seq"
OWNED BY "public"."keypair"."id";
SELECT setval('"public"."keypair_id_seq"', 498, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."mesh_id_seq"
OWNED BY "public"."mesh"."id";
SELECT setval('"public"."mesh_id_seq"', 329, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."mesh_ip_id_seq"
OWNED BY "public"."mesh_ip"."id";
SELECT setval('"public"."mesh_ip_id_seq"', 396, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."node_id_seq"
OWNED BY "public"."node"."id";
SELECT setval('"public"."node_id_seq"', 78, true);

-- ----------------------------
-- Uniques structure for table global_config
-- ----------------------------
ALTER TABLE "public"."global_config" ADD CONSTRAINT "node_id_key" UNIQUE ("node_id", "key");

-- ----------------------------
-- Primary Key structure for table global_config
-- ----------------------------
ALTER TABLE "public"."global_config" ADD CONSTRAINT "global_config_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table keypair
-- ----------------------------
ALTER TABLE "public"."keypair" ADD CONSTRAINT "keypair_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table mesh
-- ----------------------------
ALTER TABLE "public"."mesh" ADD CONSTRAINT "mesh_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table mesh_ip
-- ----------------------------
ALTER TABLE "public"."mesh_ip" ADD CONSTRAINT "mesh_ip_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table node
-- ----------------------------
CREATE UNIQUE INDEX "join_token_index" ON "public"."node" USING btree (
  "join_token" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table node
-- ----------------------------
ALTER TABLE "public"."node" ADD CONSTRAINT "node_pkey" PRIMARY KEY ("id");
