describe('Countdown helper functions', function(){
  describe('App.secsInTime', function(){
    it('should return seconds from time in milliseconds', function(){
      App.secsInTime(0).should.equal(0);
      App.secsInTime(1000).should.equal(1);
      App.secsInTime(24000).should.equal(24);
    })
  })

  describe('App.minutesInTime', function(){
    it('should return minutes from time in milliseconds', function(){
      App.minutesInTime(0).should.equal(0);
      App.minutesInTime(60 * 1000).should.equal(1);
      App.minutesInTime(10 * 60 * 1000).should.equal(10);
    })
  })

  describe('App.hoursInTime', function(){
    it('should return minutes from time in milliseconds', function(){
      App.hoursInTime(0).should.equal(0);
      App.hoursInTime(60 * 60 * 1000).should.equal(1);
      App.hoursInTime(4 * 60 * 60 * 1000).should.equal(4);
    })
  })

  describe('App.daysInTime', function(){
    it('should return minutes from time in milliseconds', function(){
      App.daysInTime(0).should.equal(0);
      App.daysInTime(24 * 60 * 60 * 1000).should.equal(1);
      App.daysInTime(5 * 24 * 60 * 60 * 1000).should.equal(5);
    })
  })
})
