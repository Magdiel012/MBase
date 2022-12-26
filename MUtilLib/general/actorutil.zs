class ActorUtil
{
	static double PitchTo(Actor this, Actor other, bool absolute = false, bool centerHeight = true)
	{
		vector3 origin = this.Pos;
		vector3 target = absolute ? other.Pos : other.PosRelative(this.cursector);

		if (centerHeight)
		{
			origin.z += this.Height / 2.0;
			target.z += other.Height / 2.0;
		}

		return -VectorAngle((target.xy - origin.xy).Length(), target.z - origin.z);
	}

	static play void Explode3D(
		Actor origin,
		int damage,
		double thrustForce,
		double radius,
		EThrustTarget thrustTarget = THRTARGET_Center,
		array<Actor> exclusions = null,
		Actor inflictor = null,
		vector3 thrustOffset = (0.0, 0.0, 0.0),
		bool checkHit = true)
	{
		LevelUtil.Explode3D(origin.Pos, damage, thrustForce, radius, thrustTarget, exclusions, origin, inflictor, thrustOffset, checkHit);
	}

	static play void Thrust3D(
		Actor target,
		vector3 direction,
		double force,
		bool overrideMomentum = false,
		bool ignoreMass = false)
	{
		if (target.bDontThrust) return;

		target.Vel = (overrideMomentum ? Vec3Util.Zero() : target.Vel)
			+ (direction.Unit() * force / (ignoreMass ? 1 : target.Mass * 0.175));
	}
}