-- CreateTable
CREATE TABLE "User" (
    "publicKey" TEXT NOT NULL,
    "twitterId" TEXT NOT NULL,
    "twitterHandle" TEXT NOT NULL,
    "twitterProfileImage" TEXT NOT NULL,
    "verificationTweetId" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("publicKey")
);

-- CreateTable
CREATE TABLE "Thread" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "firstMessageId" TEXT,
    "lastMessageId" TEXT,

    CONSTRAINT "Thread_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "threadId" TEXT NOT NULL,
    "parentId" TEXT,
    "body" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "proof" JSONB NOT NULL,
    "publicSignals" JSONB NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_group" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_twitterId_key" ON "User"("twitterId");

-- CreateIndex
CREATE UNIQUE INDEX "User_twitterHandle_key" ON "User"("twitterHandle");

-- CreateIndex
CREATE UNIQUE INDEX "Thread_firstMessageId_key" ON "Thread"("firstMessageId");

-- CreateIndex
CREATE UNIQUE INDEX "Thread_lastMessageId_key" ON "Thread"("lastMessageId");

-- CreateIndex
CREATE UNIQUE INDEX "_group_AB_unique" ON "_group"("A", "B");

-- CreateIndex
CREATE INDEX "_group_B_index" ON "_group"("B");

-- AddForeignKey
ALTER TABLE "Thread" ADD CONSTRAINT "Thread_firstMessageId_fkey" FOREIGN KEY ("firstMessageId") REFERENCES "Message"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Thread" ADD CONSTRAINT "Thread_lastMessageId_fkey" FOREIGN KEY ("lastMessageId") REFERENCES "Message"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_threadId_fkey" FOREIGN KEY ("threadId") REFERENCES "Thread"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Message"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_group" ADD CONSTRAINT "_group_A_fkey" FOREIGN KEY ("A") REFERENCES "Thread"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_group" ADD CONSTRAINT "_group_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("publicKey") ON DELETE CASCADE ON UPDATE CASCADE;
