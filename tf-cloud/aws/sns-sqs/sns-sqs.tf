locals {
    topic_names = toset([
        "coolthing",
        "somethingelse",
        "whateverman",
        "athingofsomekind"        
    ])
}

resource "aws_sns_topic" "these_sns" {
    for_each = local.topic_names
    name = each.key
    display_name = each.key
    fifo_topic = false
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  for_each = aws_sns_topic.these_sns
  topic_arn = aws_sns_topic.these_sns[each.key].arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.these_sqs[each.key].arn
}

resource "aws_sqs_queue" "these_sqs" {
    for_each = local.topic_names
    name = each.key
    fifo_queue = false
}

resource "aws_sqs_queue_policy" "test" {
    for_each = aws_sqs_queue.these_sqs
    queue_url = aws_sqs_queue.these_sqs[each.key].id
    policy = data.aws_iam_policy_document.sqs[each.key].json
}

data "aws_iam_policy_document" "sqs" {
    for_each = aws_sns_topic.these_sns
    statement {
      effect = "Allow"
      actions = [
          "sqs:SendMessage"
      ]

      principals {
          type  = "Service"
          identifiers = ["sns.amazonaws.com"]
      }

      resources = [
          aws_sqs_queue.these_sqs[each.key].arn
      ]

      condition {
          test = "ArnEquals"
          variable = "aws:SourceArn"
          values = [
              aws_sns_topic.these_sns[each.key].arn
          ]
      }
    }   
}
