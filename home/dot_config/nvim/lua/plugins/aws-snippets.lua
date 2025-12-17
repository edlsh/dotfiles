-- AWS-specific snippets for common services and patterns
return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local c = ls.choice_node

    -- AWS CloudFormation snippets
    ls.add_snippets("yaml", {
      -- EC2 Instance
      s("ec2", {
        i(1, "EC2Instance"), t({":"}),
        t({
          "",
          "  Type: AWS::EC2::Instance",
          "  Properties:",
          "    ImageId: "}), i(2, "ami-12345678"),
        t({
          "",
          "    InstanceType: "}), c(3, {
            t("t3.micro"),
            t("t3.small"),
            t("t3.medium"),
            t("m5.large"),
          }),
        t({
          "",
          "    SubnetId: !Ref "}), i(4, "PrivateSubnet"),
        t({
          "",
          "    SecurityGroupIds:",
          "      - !Ref "}), i(5, "SecurityGroup"),
        t({
          "",
          "    Tags:",
          "      - Key: Name",
          "        Value: "}), i(6, "InstanceName"),
      }),

      -- S3 Bucket
      s("s3", {
        i(1, "S3Bucket"), t({":"}),
        t({
          "",
          "  Type: AWS::S3::Bucket",
          "  Properties:",
          "    BucketName: "}), i(2, "my-bucket"),
        t({
          "",
          "    VersioningConfiguration:",
          "      Status: "}), c(3, { t("Enabled"), t("Suspended") }),
        t({
          "",
          "    BucketEncryption:",
          "      ServerSideEncryptionConfiguration:",
          "        - ServerSideEncryptionByDefault:",
          "            SSEAlgorithm: "}), c(4, { t("AES256"), t("aws:kms") }),
        t({
          "",
          "    PublicAccessBlockConfiguration:",
          "      BlockPublicAcls: true",
          "      BlockPublicPolicy: true",
          "      IgnorePublicAcls: true",
          "      RestrictPublicBuckets: true",
        }),
      }),

      -- Lambda Function
      s("lambda", {
        i(1, "LambdaFunction"), t({":"}),
        t({
          "",
          "  Type: AWS::Lambda::Function",
          "  Properties:",
          "    FunctionName: "}), i(2, "MyFunction"),
        t({
          "",
          "    Runtime: "}), c(3, {
            t("python3.11"),
            t("nodejs20.x"),
            t("python3.12"),
            t("nodejs18.x"),
          }),
        t({
          "",
          "    Handler: "}), i(4, "index.handler"),
        t({
          "",
          "    Role: !GetAtt "}), i(5, "LambdaRole.Arn"),
        t({
          "",
          "    Code:",
          "      ZipFile: |",
          "        "}), i(6, "# Lambda function code here"),
        t({
          "",
          "    Timeout: "}), i(7, "30"),
        t({
          "",
          "    MemorySize: "}), i(8, "256"),
      }),

      -- VPC
      s("vpc", {
        i(1, "VPC"), t({":"}),
        t({
          "",
          "  Type: AWS::EC2::VPC",
          "  Properties:",
          "    CidrBlock: "}), i(2, "10.0.0.0/16"),
        t({
          "",
          "    EnableDnsSupport: true",
          "    EnableDnsHostnames: true",
          "    Tags:",
          "      - Key: Name",
          "        Value: "}), i(3, "MyVPC"),
      }),

      -- Security Group
      s("sg", {
        i(1, "SecurityGroup"), t({":"}),
        t({
          "",
          "  Type: AWS::EC2::SecurityGroup",
          "  Properties:",
          "    GroupDescription: "}), i(2, "Security group description"),
        t({
          "",
          "    VpcId: !Ref "}), i(3, "VPC"),
        t({
          "",
          "    SecurityGroupIngress:",
          "      - IpProtocol: "}), i(4, "tcp"),
        t({
          "",
          "        FromPort: "}), i(5, "80"),
        t({
          "",
          "        ToPort: "}), i(6, "80"),
        t({
          "",
          "        CidrIp: "}), i(7, "0.0.0.0/0"),
        t({
          "",
          "    Tags:",
          "      - Key: Name",
          "        Value: "}), i(8, "WebServerSG"),
      }),

      -- IAM Role
      s("iamrole", {
        i(1, "IAMRole"), t({":"}),
        t({
          "",
          "  Type: AWS::IAM::Role",
          "  Properties:",
          "    RoleName: "}), i(2, "MyRole"),
        t({
          "",
          "    AssumeRolePolicyDocument:",
          "      Version: '2012-10-17'",
          "      Statement:",
          "        - Effect: Allow",
          "          Principal:",
          "            Service: "}), i(3, "lambda.amazonaws.com"),
        t({
          "",
          "          Action: sts:AssumeRole",
          "    ManagedPolicyArns:",
          "      - arn:aws:iam::aws:policy/"}), i(4, "service-role/AWSLambdaBasicExecutionRole"),
        t({
          "",
          "    Policies:",
          "      - PolicyName: "}), i(5, "CustomPolicy"),
        t({
          "",
          "        PolicyDocument:",
          "          Version: '2012-10-17'",
          "          Statement:",
          "            - Effect: Allow",
          "              Action:",
          "                - "}), i(6, "s3:GetObject"),
        t({
          "",
          "              Resource: '*'",
        }),
      }),

      -- RDS Database
      s("rds", {
        i(1, "Database"), t({":"}),
        t({
          "",
          "  Type: AWS::RDS::DBInstance",
          "  Properties:",
          "    DBInstanceIdentifier: "}), i(2, "mydb"),
        t({
          "",
          "    Engine: "}), c(3, {
            t("mysql"),
            t("postgres"),
            t("mariadb"),
            t("aurora-mysql"),
          }),
        t({
          "",
          "    MasterUsername: "}), i(4, "admin"),
        t({
          "",
          "    MasterUserPassword: !Ref "}), i(5, "DBPassword"),
        t({
          "",
          "    DBInstanceClass: "}), i(6, "db.t3.micro"),
        t({
          "",
          "    AllocatedStorage: "}), i(7, "20"),
        t({
          "",
          "    VPCSecurityGroups:",
          "      - !Ref "}), i(8, "DatabaseSecurityGroup"),
      }),

      -- DynamoDB Table
      s("dynamodb", {
        i(1, "DynamoDBTable"), t({":"}),
        t({
          "",
          "  Type: AWS::DynamoDB::Table",
          "  Properties:",
          "    TableName: "}), i(2, "MyTable"),
        t({
          "",
          "    AttributeDefinitions:",
          "      - AttributeName: "}), i(3, "id"),
        t({
          "",
          "        AttributeType: "}), c(4, { t("S"), t("N"), t("B") }),
        t({
          "",
          "    KeySchema:",
          "      - AttributeName: "}), i(5, "id"),
        t({
          "",
          "        KeyType: HASH",
          "    BillingMode: "}), c(6, { t("PAY_PER_REQUEST"), t("PROVISIONED") }),
      }),
    })

    -- Terraform AWS snippets
    ls.add_snippets("terraform", {
      -- AWS Provider
      s("awsprovider", {
        t({
          "provider \"aws\" {",
          "  region = \""}), i(1, "us-east-1"), t({"\""}),
        t({
          "",
          "  profile = \""}), i(2, "default"), t({"\""}),
        t({
          "",
          "}",
        }),
      }),

      -- EC2 Instance
      s("awsec2", {
        t({"resource \"aws_instance\" \""}), i(1, "example"), t({"\" {"}),
        t({
          "",
          "  ami           = \""}), i(2, "ami-12345678"), t({"\""}),
        t({
          "",
          "  instance_type = \""}), i(3, "t3.micro"), t({"\""}),
        t({
          "",
          "  subnet_id     = "}), i(4, "aws_subnet.main.id"),
        t({
          "",
          "",
          "  tags = {",
          "    Name = \""}), i(5, "example-instance"), t({"\""}),
        t({
          "",
          "  }",
          "}",
        }),
      }),

      -- S3 Bucket
      s("awss3", {
        t({"resource \"aws_s3_bucket\" \""}), i(1, "bucket"), t({"\" {"}),
        t({
          "",
          "  bucket = \""}), i(2, "my-bucket"), t({"\""}),
        t({
          "",
          "}",
          "",
          "resource \"aws_s3_bucket_versioning\" \""}), i(3, "bucket_versioning"), t({"\" {"}),
        t({
          "",
          "  bucket = aws_s3_bucket."}), i(4, "bucket"), t({".id"}),
        t({
          "",
          "  versioning_configuration {",
          "    status = \""}), c(5, { t("Enabled"), t("Disabled") }), t({"\""}),
        t({
          "",
          "  }",
          "}",
        }),
      }),
    })
  end,
}