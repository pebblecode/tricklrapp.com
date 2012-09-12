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

  describe('App.timeToString', function() {
    describe('days', function() {
      it('should return about 1 day', function() {
        App.timeToString(24 * 60 * 60 * 1000).should.equal('about 1 day')
      })

      it('should return about 15 days', function() {
        App.timeToString(15 * 24 * 60 * 60 * 1000).should.equal('about 15 days')
      })
    })

    describe('hours', function() {
      it('should return about 1 hour', function() {
        App.timeToString(60 * 60 * 1000).should.equal('about 1 hour')
      })

      it('should return about 15 hours', function() {
        App.timeToString(15 * 60 * 60 * 1000).should.equal('about 15 hours')
      })
    })

    describe('minutes', function() {
      it('should return about 1 minute', function() {
        App.timeToString(60 * 1000).should.equal('about 1 minute')
      })

      it('should return about 15 minutes', function() {
        App.timeToString(15 * 60 * 1000).should.equal('about 15 minutes')
      })
    })

    describe('seconds', function() {
      it('should return 0 seconds', function() {
        App.timeToString(0).should.equal('0 seconds')
      })

      it('should return 1 second', function() {
        App.timeToString(1000).should.equal('1 second')
      })

      it('should return 15 seconds', function() {
        App.timeToString(15 * 1000).should.equal('15 seconds')
      })
    })
  })
})
