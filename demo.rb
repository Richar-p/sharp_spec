# test_comment:begin
# expect: [true, false]
# test_comment:end
def my_demo_method
  [true, false].sample
end

# test_comment:begin
# expect: greater than 0
# test_comment:end
def my_demo_method_gt = 4
