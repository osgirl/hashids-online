j = jQuery.noConflict()

encode = ->
  salt = j('#salt').val()
  min_len = parseInt j('#min-length').val()
  hashids = new Hashids(salt, min_len);
  nums = j('#numbers').val().split(',')
  numbers = for i, n of nums
    parseInt n

  id = hashids.encode.apply(hashids, numbers)
  j('#result').val id

j(document).ready ->
  j('#calc').on 'click', (event) ->
    encode()
    event.preventDefault()
