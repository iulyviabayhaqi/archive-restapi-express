-- CreateTable
CREATE TABLE "PsikologJobs" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PsikologJobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "type" VARCHAR(20) NOT NULL,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "photo_url" VARCHAR(100),
    "email" VARCHAR(50) NOT NULL,
    "no_hp" VARCHAR(13),
    "birthday" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "roleId" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "psikolog_additional_data" (
    "psychologist_id" TEXT NOT NULL,
    "nik" VARCHAR(50) NOT NULL,
    "certificate_credential" VARCHAR(20) NOT NULL,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "photo_url" VARCHAR(100),
    "email" VARCHAR(50) NOT NULL,
    "current_job_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "psikolog_additional_data_pkey" PRIMARY KEY ("psychologist_id")
);

-- CreateTable
CREATE TABLE "psikolog_akses_psikologi_tools" (
    "id" TEXT NOT NULL,
    "current_job_id" TEXT NOT NULL,
    "class" VARCHAR(1) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "psikolog_akses_psikologi_tools_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "result" (
    "id" TEXT NOT NULL,
    "psikologi_tools_id" TEXT NOT NULL,
    "psikolog_additional_data_id" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "result_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "psikologi_tools" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "class" VARCHAR(1) NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "psikologi_tools_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TreatmentSession" (
    "id" TEXT NOT NULL,
    "psikolog_id" TEXT NOT NULL,
    "client_id" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TreatmentSession_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_name" ON "PsikologJobs"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "psikolog_additional_data_email_key" ON "psikolog_additional_data"("email");

-- CreateIndex
CREATE INDEX "idx_psikolog_id" ON "TreatmentSession"("psikolog_id");

-- CreateIndex
CREATE INDEX "idx_client_id" ON "TreatmentSession"("client_id");

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "psikolog_additional_data" ADD CONSTRAINT "psikolog_additional_data_psychologist_id_fkey" FOREIGN KEY ("psychologist_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "psikolog_additional_data" ADD CONSTRAINT "psikolog_additional_data_current_job_id_fkey" FOREIGN KEY ("current_job_id") REFERENCES "PsikologJobs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "psikolog_akses_psikologi_tools" ADD CONSTRAINT "psikolog_akses_psikologi_tools_current_job_id_fkey" FOREIGN KEY ("current_job_id") REFERENCES "PsikologJobs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "result" ADD CONSTRAINT "result_psikologi_tools_id_fkey" FOREIGN KEY ("psikologi_tools_id") REFERENCES "psikologi_tools"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "result" ADD CONSTRAINT "result_psikolog_additional_data_id_fkey" FOREIGN KEY ("psikolog_additional_data_id") REFERENCES "psikolog_additional_data"("psychologist_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TreatmentSession" ADD CONSTRAINT "TreatmentSession_psikolog_id_fkey" FOREIGN KEY ("psikolog_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TreatmentSession" ADD CONSTRAINT "TreatmentSession_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
